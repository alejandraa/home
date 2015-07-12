from subprocess import check_output
from string import Template

def get_password(account=None):
    tmpl = Template("echo $ONEPASSWORD_MASTER_PASSWORD | 1pass --no-prompt '$name'")
    command = tmpl.safe_substitute(name=account)
    return check_output(command, shell=True).rstrip("\r\n")
