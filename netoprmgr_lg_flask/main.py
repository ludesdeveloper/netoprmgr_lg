import re
from list_devices import devices
from netmiko import ConnectHandler
from flask import Flask, render_template, request, jsonify
from flask_cors import CORS
app = Flask(__name__)
CORS(app)

@app.route('/api/v1/traceroute', methods=['POST'])
def traceroute():

    sourceip = request.form.get('sourceip')
    destinationip = request.form.get('destinationip')

    print(sourceip)
    print(destinationip)

    trace_routes_result = {}
    trace_routes_list = []
    trace_routes = []
    #from source trace to destination
    try:
        for sourcedevice in devices:
            if sourcedevice['ip'] == sourceip:
                print('trace src')
                trace_routes.append(f'From {sourceip} to {destinationip}')
                net_connect = ConnectHandler(**sourcedevice)
                output = net_connect.send_command_expect(f"traceroute {destinationip}")
                print(output)
                regex_routes = re.findall('.*\d+[.]\d+[.]\d+[.]\d+.*', output)
                trace_routes.extend(regex_routes)
    except:
        trace_routes.append('Can Not Trace From Source to Destination')

    try:
        #from destination trace to source
        for destinationdevice in devices:
            if destinationdevice['ip'] == destinationip:
                print('trace dst')
                trace_routes.append(f'From {destinationip} to {sourceip}')
                net_connect = ConnectHandler(**destinationdevice)
                output = net_connect.send_command_expect(f"traceroute {sourceip}")
                print(output)
                regex_routes = re.findall('.*\d+[.]\d+[.]\d+[.]\d+.*', output)
                trace_routes.extend(regex_routes)
    except:
        trace_routes.append('Can Not Trace From Destination to Source')

    trace_routes.append('')
    trace_routes_result = {"traceroute" : trace_routes}
    print(trace_routes_result)

    return jsonify(trace_routes_result)

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')