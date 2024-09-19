FROM netboxcommunity/netbox:latest

COPY ./plugin_requirements.txt /opt/netbox/
RUN /opt/netbox/venv/bin/pip install  --no-warn-script-location -r /opt/netbox/plugin_requirements.txt

# These lines are only required if your plugin has its own static files.
COPY config/configuration.py /etc/netbox/config/configuration.py
COPY config/plugins.py /etc/netbox/config/plugins.py
COPY config/local_settings.py /opt/netbox/netbox/netbox/local_settings.py
RUN SECRET_KEY="dummydummydummydummydummydummydummydummydummydummy" /opt/netbox/venv/bin/python /opt/netbox/netbox/manage.py collectstatic --no-input
