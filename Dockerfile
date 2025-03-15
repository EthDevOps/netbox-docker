FROM netboxcommunity/netbox:latest

COPY ./plugin_requirements.txt /opt/netbox/
ENV VIRTUAL_ENV=/opt/netbox/venv
RUN /usr/local/bin/uv pip install -r /opt/netbox/plugin_requirements.txt

# Fix For Topology Views (Remove once https://github.com/netbox-community/netbox-topology-views/pull/608 is added )
RUN sed -i 's/settings\.VERSION/settings\.RELEASE\.version/g' /opt/netbox/venv/lib/python3.12/site-packages/netbox_topology_views/template_content.py


# These lines are only required if your plugin has its own static files.
COPY config/configuration.py /etc/netbox/config/configuration.py
COPY config/plugins.py /etc/netbox/config/plugins.py
COPY config/local_settings.py /opt/netbox/netbox/netbox/local_settings.py
RUN mkdir -p /opt/netbox/netbox/static/netbox_topology_views/img
RUN SECRET_KEY="dummydummydummydummydummydummydumminitial commiinitial committydummydummydummy" /opt/netbox/venv/bin/python /opt/netbox/netbox/manage.py collectstatic --no-input
