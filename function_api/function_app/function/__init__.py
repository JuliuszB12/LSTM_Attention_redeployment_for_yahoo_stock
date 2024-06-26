import os
import azure.functions as func
from azureml.core.authentication import MsiAuthentication
from azureml.core.webservice import AksWebservice
from azureml.core import Workspace


def main(req: func.HttpRequest) -> func.HttpResponse:
    try:
        # Try to get JSON from the request body
        req_body = req.get_json()
    except ValueError:
        # If JSON parsing fails, return a 400 error
        return func.HttpResponse("Invalid JSON", status_code=400)

    inputs = req_body.get('inputs')
    
    subscriptionId = os.getenv('subscriptionId')
    resourceGroup = os.getenv('resourceGroup')
    msi_auth = MsiAuthentication()
    ws = Workspace(subscription_id=subscriptionId, 
                   resource_group=resourceGroup, 
                   workspace_name="mlserving", 
                   auth=msi_auth)
    service = AksWebservice(ws, 'lstm-service')
    response = service.run(input_data=inputs)

    if response:
        return func.HttpResponse(response, status_code=200)
    else:
        return func.HttpResponse("Please pass input in the request body", status_code=400)
