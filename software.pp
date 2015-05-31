# Command-line utilities
package { 'git.install':
  ensure   => latest,
  provider => 'chocolatey',
}
package { 'conemu':
  ensure   => latest,
  provider => 'chocolatey',
}
package { 'poshgit':
  ensure   => latest,
  provider => 'chocolatey',
}
package { 'psget':
  ensure   => latest,
  provider => 'chocolatey',
}
# Editors
package { 'notepadplusplus.install':
  ensure   => latest,
  provider => 'chocolatey',
}
package { 'vim':
  ensure   => latest,
  provider => 'chocolatey',
}
# Other software
package { 'putty.install':
  ensure   => latest,
  provider => 'chocolatey',
}
package { 'kitty.portable':
  ensure   => latest,
  provider => 'chocolatey',
}
package { '7zip.install':
  ensure   => latest,
  provider => 'chocolatey',
}
package { 'googlechrome':
  ensure   => latest,
  provider => 'chocolatey',
}
package { 'firefox':
  ensure   => latest,
  provider => 'chocolatey',
}
package { 'thunderbird':
  ensure   => latest,
  provider => 'chocolatey',
}
package { 'gpg4win':
  ensure   => latest,
  provider => 'chocolatey',
}
package { 'tortoisesvn':
  ensure   => latest,
  provider => 'chocolatey',
}
package { 'tortoisegit':
  ensure   => latest,
  provider => 'chocolatey',
  #install_options => ['-installArgs', 'MSIRESTARTMANAGERCONTROL=Disable'],
}
package { 'winscp':
  ensure   => latest,
  provider => 'chocolatey',
}
package { 'intellijidea-community':
  ensure   => latest,
  provider => 'chocolatey',
}
package { 'jdk7':
  ensure   => latest,
  provider => 'chocolatey',
}
package { 'jdk8':
  ensure   => latest,
  provider => 'chocolatey',
}
