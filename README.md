# dlProxy Downloads proxy in Powershell

## Documentation
### Files
- `squid.ps1`: Helper script for developing and deploying the squid container. This script contains
  helper functions for managing the container.
- `./squid/squid.conf`: Configuration for squid see: <https://www.squid-cache.org/Doc/config/>.
Copied over during build.
- `./squid/entrypoint.sh`: Script run as first processby the container.
- `./squid/Dockerfile`: File for building squid container. 

### Squid
- [ ] For now the only configuration in the config file is `http_access allow all`. This is because I do

## Planning
Deadline: 05/01/2024
### Week 1 (09-15/12/2024)
- [ ] SMB drive with docker container and file CRUD operations via SmbShare
- [ ] Squid deployment using docker
- [ ] Server service installation
    - able to send installation requsets for .exe
- [ ] Client service installation
    - able to receive requests

### Week 2 (16-22/12/2024)
- [ ] Chocolatey & Winget installation support
- [ ] Squid caching finetuned for Choclatey & Winget
- [ ] AWS S3 support
- [ ] Manual installation steps in prompt
- [ ] VM testing
- [ ] Admin UI

### Week 3 (23-29/12/2024)
- [ ] MVP afwerken/robust maken
- [ ] Checksums
- [ ] Powershell API voor integratie
- [ ] Reject non-signed software

### Week 4 (30-04/12/2024)
- [ ] Software updates/upgrades
- [ ] More info about software (download link, signed, ...)
- [ ] What could not be done in Week 1, 2 and 3
