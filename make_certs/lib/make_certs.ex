defmodule MakeCerts do
  def make_server_certs() do
    ca_key = X509.PrivateKey.new_ec(:secp256r1)
    ca = X509.Certificate.self_signed(ca_key, "/CN=CA for server", template: :root_ca)

    server_key = X509.PrivateKey.new_ec(:secp256r1)
    server_pub_key = X509.PublicKey.derive(server_key)
    server = X509.Certificate.new(server_pub_key, "/CN=The server", ca, ca_key, extensions: [ subject_alt_name: X509.Certificate.Extension.subject_alt_name(["localhost"])])

    File.write!("ca.pem", X509.Certificate.to_pem(ca))
    File.write!("ca-key.pem", X509.PrivateKey.to_pem(ca_key))
    File.write!("server.pem", X509.Certificate.to_pem(server))
    File.write!("server-key.pem", X509.PrivateKey.to_pem(server_key))
  end

  def make_client_certs() do
    {signer, signer_key} = NervesKey.create_signing_key_pair()

    device_key = X509.PrivateKey.new_ec(:secp256r1)
    device_pub_key = X509.PublicKey.derive(device_key)
    device = X509.Certificate.new(device_pub_key, "/CN=A device", signer, signer_key)

    File.write!("signer.pem", X509.Certificate.to_pem(signer))
    File.write!("signer-key.pem", X509.PrivateKey.to_pem(signer_key))

    File.write!("device.pem", X509.Certificate.to_pem(device))
    File.write!("device-key.pem", X509.PrivateKey.to_pem(device_key))

  end

  def make_all() do
    make_client_certs()
    make_server_certs()
  end
end
