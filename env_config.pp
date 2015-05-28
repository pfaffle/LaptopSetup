$user = 'pfaffle'
$realname = 'Craig Meinschein'
$userprofile = ["C:/Users/$user/","C:/Users/$user/AppData/","C:/Users/$user/AppData/Roaming"]

user { $user:
	ensure     => present,
	comment    => $realname,
	groups     => ['Administrators','Users'],
	managehome => true,
	password   => 'Temppass1',
}

file { $userprofile:
	ensure             => directory,
	source_permissions => ignore,
}

windows_env { 'GIT_SSH':
	ensure    => present,
	mergemode => clobber,
	user      => $user,
	value     => 'C:\Program Files (x86)\PuTTY\plink.exe',
}

file { 'ConEmu config':
	ensure             => file,
	path               => "${$userprofile[2]}/ConEmu.xml",
	source             => 'Z:/LaptopSetup/ConEmu.xml',
	source_permissions => ignore,
}
