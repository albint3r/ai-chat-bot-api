class DataBaseMySQLStillNotExistError(Exception):
    """This error Triggers when the Database is created the first time and still is not available for the api"""
