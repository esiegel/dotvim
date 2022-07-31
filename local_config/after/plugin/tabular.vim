" Patterns
AddTabularPattern first_, /^[^,]*\zs,/l0c0l0
AddTabularPattern first_= /^[^=]*\zs=/l0c0l0
AddTabularPattern first_space /^[^ ]*\zs /l0c0l0
AddTabularPattern first_: /^[^:]*\zs:/l0c0l0

AddTabularPattern first_,_r /^[^,]*\zs,/r0c0l0
AddTabularPattern first_=_r /^[^=]*\zs=/r0c0l0
AddTabularPattern first_space_r /^[^ ]*\zs /r0c0l0
AddTabularPattern first_:_r /^[^:]*\zs:/r0c0l0

AddTabularPattern last_: /^.*\zs:
