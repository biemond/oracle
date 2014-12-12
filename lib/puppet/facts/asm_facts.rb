#
# Oracle Grid Infrastructure (ASM) facts
#
Facter.add('ora_asm_disk') do
  setcode do
    asm_volumes = run_as_grid("asmcmd volinfo -a | awk '/Diskgroup Name: / {print $3}'")
    asm_devices = run_as_grid("asmcmd volinfo -a | awk '/Volume Device: / {print $3}'")
    Hash[zip(asm_volumes, asm_devices)]
  end
end

def run_as_grid(cmd)
  sid = '+ASM1' # TODO: Make the definable
  full_command = "su - grid -c 'export ORACLE_SID=#{sid};export ORAENV_ASK=NO;. oraenv;#{cmd}'"
  Facter::Util::Resolution.exec(full_command)
end



