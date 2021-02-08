import logging
import traceback

logger = logging.getLogger()


def lambda_handler(event, context):
    try:
        if "ELB-HealthChecker" in event.get("headers").get("user-agent"):
            return {
                "statusCode": 200,
                "statusDescription": "200 OK",
                "isBase64Encoded": False,
                "headers": {
                    "Content-Type": "text/html; charset=utf-8"
                }
            }
        else:
            return {
                "statusCode": 401,
                "statusDescription": "401 Unauthorized",
                "isBase64Encoded": False,
                "headers": {
                    "WWW-Authenticate": "Basic",
                    "Content-Type": "text/html; charset=utf-8"
                }
            }

    except Exception:
        logger.error({"event": event, "traceback": traceback.format_exc()})
