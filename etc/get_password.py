import os, string

def get_password(account=None):
    key = "{0}_MAIL_PASSWORD".format(account)
    return os.environ[key]
