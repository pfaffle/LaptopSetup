windows_env { 'GIT_SSH':
	ensure    => present,
	mergemode => clobber,
	user      => $::id,
	value     => 'C:\Program Files (x86)\PuTTY\plink.exe',
}