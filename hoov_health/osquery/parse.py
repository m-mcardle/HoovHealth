# Parse results to flag potential issues
def parse_and_flag(results):
    flags = []
    # Check for SSH (port 22) as an example
    if any(port["port"] == "22" for port in results["listening_ports"]):
        flags.append("SSH port 22 is open; review if required.")
    return flags