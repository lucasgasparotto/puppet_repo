URL Shortcode https://goo.gl/mtEMXK

# Lab 2.2: Running commands
  ## Task 1: Run local system commands
    Step 1
      Steps for Windows:
        PS C:\> bolt command run 'net stop w32time' --nodes winrm://localhost --user Administrator --no-ssl --password
      
      Steps for Linux:
        $ bolt command run 'sudo systemctl stop ntpd' --nodes ssh://localhost --user centos --no-host-key-check
        
  ## Task 2: Run remote system commands
    Step 1
      Steps for Windows:
        PS C:\> bolt command run 'sudo systemctl start ntpd' --nodes ssh://<your-linuxmachine>.classroom.puppet.com --private-key C:\keys\private_key.pem --user centos --no-host-key-check

      Steps for Linux:
        $ bolt command run 'net start w32time' --nodes winrm://<your-windows-machine>.classroom.puppet.com --user Administrator --no-ssl --password

    Step 2
      Steps for Windows:
        PS C:\> bolt command run 'sudo systemctl status ntpd' --nodes ssh://<your-linuxmachine>.classroom.puppet.com --private-key C:\keys\private_key.pem --user centos --no-host-key-check

      Steps for Linux:
        $ bolt command run 'Get-Service w32time' --nodes winrm://<your-windows-machine>.classroom.puppet.com --user Administrator --no-ssl --password

  ## Task 3: Run scripts
    Step 1
      Steps for Windows:
        PS C:\> bolt script run C:\tools\linux.sh --nodes ssh://<your-linux-machine>.classroom.puppet.com --private-key C:\keys\private_key.pem --user centos --no-host-key-check --run-as root

      Steps for Linux
        $ bolt script run /tools/windows.ps1 --nodes winrm://<your-windows-machine>.classroom.puppet.com --user Administrator --no-ssl --password

# Lab 7.1: Puppet forge
  ## Task 1: Learn the Puppet Forge web site interface
    Code: *** See attached file for the init.pp
    Step 4
      Steps for Windows:
        PS C:\Users\Administrator> puppet config print modulepath 'C:/ProgramData/PuppetLabs/code/environments/production/modules;C:/ProgramData/PuppetLabs/code/modules;C:/opt/puppetlabs/puppet/modules'           

      Steps for Linux:
        $ sudo puppet config print modulepath /etc/puppetlabs/code/environments/production/modules:/root/puppetcode/modules:/etc/puppetlabs/code/modules

# Lab 8.1: Create a wrapper module
  ## Task 2: Add classes to your wrapper class
    Code: *** See attached file for the init.pp

# Lab 10.1 Create roles and profiles
  ## Task 3: Create Bastion Host Role
    Step 3
      Steps for Windows
        cd c:\Users\Administrator\control-repo\site\role
        # This is the smoke test. --noop is a dry-run.
        puppet apply examples\bastion.pp --modulepath='C:/ProgramData/PuppetLabs/code/environments/production/modules;C:/Users/Administrator/control-repo/site;C:/Users/Administrator' --noop
        
        # Apply for real
        puppet apply examples\bastion.pp --modulepath='C:/ProgramData/PuppetLabs/code/environments/production/modules;C:/Users/Administrator/control-repo/site;C:/Users/Administrator'

      Steps for Linux
        cd control-repo/site/role
        # This is the smoke test. --noop is a dry-run.
        puppet apply examples/bastion.pp --modulepath=/etc/puppetlabs/code/environments/production/modules:/home/centos/control-repo/site:/home/centos --noop

        # Apply it for real
        puppet apply examples/bastion.pp --modulepath=/etc/puppetlabs/code/environments/production/modules:/home/centos/control-repo/site:/home/centos

# Lab 12.1: Expand initial roles and profiles
  ## Task 1
    Step 2 *** See attached file for the firewall.pp
    Step 3 *** See attached file for the ssh_config.pp
    Step 4 *** See attached file for the security_baseline.pp
    
    Step 6 (Optional)
      Steps for Windows
        cd C:\Users\Administrator\control-repo\site
        puppet apply profile\examples\security_baseline.pp --modulepath='C:/ProgramData/PuppetLabs/code/environments/production/modules;C:/ProgramData/PuppetLabs/code/modules;.' --noop
        
      Steps for Linux
        cd control-repo/site
        # This is the smoke test.
        puppet apply profile/examples/security_baseline.pp --modulepath=/etc/puppetlabs/code/environments/production/modules:/home/centos/control-repo/site:/home/centos --noop

