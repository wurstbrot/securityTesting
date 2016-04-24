#! /bin/bash

LOCALES=(
    "en_GB.UTF-8"
    "en_US.UTF-8"
    "es_ES.UTF-8"
    "fr_FR.UTF-8"
    "it_IT.UTF-8"
    "pt_PT.UTF-8"
    "de_DE.UTF-8"
    "de_CH.UTF-8"
    "de_AT.UTF-8"
    "nl_NL.UTF-8"
    "ru_RU.UTF-8"
    "ar_SA.UTF-8"
    "zh_CN.UTF-8"
    "ja_JP.UTF-8"
)

for LOCALE in "${LOCALES[@]}"; do
  if grep "$LOCALE" /usr/share/i18n/SUPPORTED >/dev/null ; then
    if ! grep "$LOCALE" /var/lib/locales/supported.d/local >/dev/null ; then
      echo "Installing locale $LOCALE:"
      locale-gen "$LOCALE"
    fi
  else
    echo "ERROR: Cannot install locale $LOCALE! This locale is not supported."
  fi
done

echo "Updating all locales:"
dpkg-reconfigure locales

exit 0