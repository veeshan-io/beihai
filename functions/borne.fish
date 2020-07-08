function borne -d "Init borne local"
  set -l name (hostname)
  set -l inv (beihai bornes $name)
  if test -z "$inv"
    echo Inventory for borne $inv is not exists.
    return $OMF_UNKNOWN_OPT
  end

  koi debug "RUN: ansible-playbook -i $inv "(beihai books borne)
  ansible-playbook -i $inv (beihai books borne)
end
