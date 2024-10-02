import sys
import requests
from datetime import datetime,timedelta
from googleapiclient import discovery
from oauth2client.client import GoogleCredentials
from typing import Any, Optional
import os
from google.api_core.extended_operation import ExtendedOperation
from google.cloud import compute_v1

import functions_framework


def wait_for_extended_operation(
    operation: ExtendedOperation, verbose_name: str = "operation", timeout: int = 300
) -> Any:
    """
    Waits for the extended (long-running) operation to complete.

    If the operation is successful, it will return its result.
    If the operation ends with an error, an exception will be raised.
    If there were any warnings during the execution of the operation
    they will be printed to sys.stderr.

    Args:
        operation: a long-running operation you want to wait on.
        verbose_name: (optional) a more verbose name of the operation,
            used only during error and warning reporting.
        timeout: how long (in seconds) to wait for operation to finish.
            If None, wait indefinitely.

    Returns:
        Whatever the operation.result() returns.

    Raises:
        This method will raise the exception received from `operation.exception()`
        or RuntimeError if there is no exception set, but there is an `error_code`
        set for the `operation`.

        In case of an operation taking longer than `timeout` seconds to complete,
        a `concurrent.futures.TimeoutError` will be raised.
    """
    result = operation.result(timeout=timeout)

    if operation.error_code:
        print(
            f"Error during {verbose_name}: [Code: {operation.error_code}]: {operation.error_message}",
            file=sys.stderr,
            flush=True,
        )
        print(f"Operation ID: {operation.name}", file=sys.stderr, flush=True)
        raise operation.exception() or RuntimeError(operation.error_message)

    if operation.warnings:
        print(f"Warnings during {verbose_name}:\n", file=sys.stderr, flush=True)
        for warning in operation.warnings:
            print(f" - {warning.code}: {warning.message}", file=sys.stderr, flush=True)

    return result


@functions_framework.http
def create_snapshot(request):
    
    
    compute_client = compute_v1.ProjectsClient()
    curr_project_id = os.environ.get('GCP_PROJECT')

    project_response = compute_client.get(project=curr_project_id)
    metadataarr = {}
    for data in project_response.common_instance_metadata.items:
        metadataarr[data.key] = data.value


    process_status = metadataarr['process_status']
    env_type = metadataarr['env_type']
    
    if(process_status == 'init'):
        return 'snapshot not created'
    
    previous_date = (datetime.today() - timedelta(days=3)).strftime('%Y-%m-%d')
    snapshot_name_prev = f'snapshot-backup-mail-ssd-{str(previous_date)}'

    todays_date = datetime.today().strftime('%Y-%m-%d')
    project_id = ''+env_type+'-phoneemail-backup'
    disk_name = 'mail-ssd'
    snapshot_name = f'snapshot-backup-mail-ssd-{str(todays_date)}'
    zone = 'asia-south1-a'
    region = None
    location = 'asia-south1'
    disk_project_id = os.environ.get('GCP_PROJECT')
    """
    Create a snapshot of a disk.

    You need to pass `zone` or `region` parameter relevant to the disk you want to
    snapshot, but not both. Pass `zone` parameter for zonal disks and `region` for
    regional disks.

    Args:
        project_id: project ID or project number of the Cloud project you want
            to use to store the snapshot.
        disk_name: name of the disk you want to snapshot.
        snapshot_name: name of the snapshot to be created.
        zone: name of the zone in which is the disk you want to snapshot (for zonal disks).
        region: name of the region in which is the disk you want to snapshot (for regional disks).
        location: The Cloud Storage multi-region or the Cloud Storage region where you
            want to store your snapshot.
            You can specify only one storage location. Available locations:
            https://cloud.google.com/storage/docs/locations#available-locations
        disk_project_id: project ID or project number of the Cloud project that
            hosts the disk you want to snapshot. If not provided, will look for
            the disk in the `project_id` project.

    Returns:
        The new snapshot instance.
    """
    if zone is None and region is None:
        raise RuntimeError(
            "You need to specify `zone` or `region` for this function to work."
        )
    if zone is not None and region is not None:
        raise RuntimeError("You can't set both `zone` and `region` parameters.")

    if disk_project_id is None:
        disk_project_id = project_id

    if zone is not None:
        disk_client = compute_v1.DisksClient()
        disk = disk_client.get(project=disk_project_id, zone=zone, disk=disk_name)
    else:
        regio_disk_client = compute_v1.RegionDisksClient()
        disk = regio_disk_client.get(
            project=disk_project_id, region=region, disk=disk_name
        )
        
    try:    
        snapshot_client = compute_v1.SnapshotsClient()
        operation = snapshot_client.delete(project=project_id, snapshot=snapshot_name)
    except Exception as e:
        pass
    
    
    try:    
        snapshot_client = compute_v1.SnapshotsClient()
        operation = snapshot_client.delete(project=project_id, snapshot=snapshot_name_prev)
    except Exception as e:
        pass
        

    type = request.args.get('type')
    
    if(type =='disk'):    
        snapshot = compute_v1.Snapshot()
        snapshot.source_disk = disk.self_link
        snapshot.name = snapshot_name
        if location:
            snapshot.storage_locations = [location]

        snapshot_client = compute_v1.SnapshotsClient()
        operation = snapshot_client.insert(project=project_id, snapshot_resource=snapshot)

        wait_for_extended_operation(operation, "snapshot creation")
    
    
    if(type =='userdb'):
        # response = requests.post(f'https://sqladmin.googleapis.com/sql/v1beta4/projects/{curr_project_id}/instances/tf-sendbox-inst/export', data = {"exportContext": {"fileType": "SQL","uri": "gs://dev-codegcp-backup-db-mailbox/user_db.sql","databases": ["user_db"], "offload": False}})
        # return str(response)
        credentials = GoogleCredentials.get_application_default()

        service = discovery.build('sqladmin', 'v1beta4', credentials=credentials)

        # Project ID of the project that contains the instance to be exported.
        project = curr_project_id  # TODO: Update placeholder value.

        # Cloud SQL instance ID. This does not include the project ID.
        instance = 'tf-userdb'  # TODO: Update placeholder value.

        instances_export_request_body = {
            "exportContext": {"fileType": "SQL","uri": "gs://"+env_type+"-phoneemail-backup-db-mailbox/user_db.sql","databases": ["user_db"], "offload": False}
        }
        

        request = service.instances().export(project=project, instance=instance, body=instances_export_request_body)
        response = request.execute()
        return str(response)

    

    return 'Hello {}!'