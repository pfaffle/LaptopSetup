$account = split($::id,'\\')
$user = $account[1]

windows_env { 'GIT_SSH':
	ensure    => present,
	mergemode => clobber,
	user      => $user,
	value     => 'C:\Program Files (x86)\PuTTY\plink.exe',
}
