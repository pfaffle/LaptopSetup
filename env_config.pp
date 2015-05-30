$user = 'pfaffle'
$realname = 'Craig Meinschein'
$userprofile = ["C:/Users/$user/","C:/Users/$user/AppData/","C:/Users/$user/AppData/Roaming"]
$tbprofiledir = ["${$userprofile[2]}/Thunderbird","${$userprofile[2]}/Thunderbird/Profiles","${$userprofile[2]}/Thunderbird/Profiles/76818gag.default"]

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

windows_env { 'PSModulePath':
	ensure    => present,
	value     => 'C:\Program Files\Common Files\Modules',
	separator => ';',
}

file { 'ConEmu config':
	ensure             => file,
	path               => "${$userprofile[2]}/ConEmu.xml",
	source             => 'Z:/LaptopSetup/Profile/ConEmu.xml',
	source_permissions => ignore,
}

file { $tbprofiledir:
	ensure             => directory,
	source_permissions => ignore,
}

file { 'Thunderbird profile ini':
	ensure             => file,
	path               => "${$tbprofiledir[0]}/profiles.ini",
	source             => 'Z:/LaptopSetup/Profile/Thunderbird/profiles.ini',
	source_permissions => ignore,
}

file { 'Thunderbird profile prefs`':
	ensure             => file,
	path               => "${$tbprofiledir[2]}/prefs.js",
	source             => 'Z:/LaptopSetup/Profile/Thunderbird/Profiles/76818gag.default/prefs.js',
	source_permissions => ignore,
}

