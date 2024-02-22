import paramiko
from scp import SCPClient
import os


def search_path(host, port, username, password, command):
    # Crea un oggetto SSHClient
    client = paramiko.SSHClient()
    # Aggiungi la chiave host se non è presente
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    try:
        client.connect(host, port=port, username=username, password=password)
        stdin, stdout, stderr = client.exec_command(command)
        output = stdout.read().decode("utf-8")
        return output
    except Exception as e:
        print(f"Errore durante la connessione SSH: {e}")
    finally:
        client.close()


def recupera_cartella_scp(
    host, port, username, password, cartella_remota, cartella_locale
):
    # Crea un oggetto Transport per gestire la connessione
    transport = paramiko.Transport((host, port))
    transport.connect(username=username, password=password)

    try:
        # Crea un oggetto SCPClient per trasferire file tramite SCP
        with SCPClient(transport) as scp:
            scp.get(cartella_remota, cartella_locale, recursive=True)
        mkdir(cartella_locale, cartella_remota)

    except Exception as e:
        print(f"Errore durante il recupero della cartella: {e}")

    finally:
        transport.close()


def mkdir(cartella_locale, cartella_remota):
    nuova_cartella_locale = os.path.join(
        cartella_locale, os.path.basename(cartella_remota)
    )
    os.rename(cartella_locale, nuova_cartella_locale)


if __name__ == "__main__":
    containers = [
        "client-200",
        "R203",
        "R202",
        "R201",
        "R101",
        "R102",
        "R103",
        "R301",
        "R302",
        "GW300",
        "R401",
        "R402",
        "client-400",
        "A1",
        "A2",
        "B1",
        "B2",
    ]

    host = "192.168.56.101"
    port = 22
    username = "gns3"
    password = "gns3"

    for c in containers:
        sentinel = f"IM_{c.upper()}"
        command = f"find / -name .{sentinel} 2>/dev/null"
        path = search_path(host, port, username, password, command)
        path = path[: path.find(sentinel)]

        recupera_cartella_scp(host, port, username, password, path, c)
