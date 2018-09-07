if [ -f "variables.bash" ]; then
  source "variables.bash"
fi

if [ -f "secrets.bash" ]; then
  source "secrets.bash"
fi

if [ -f "general.bash" ]; then
  source "general.bash"
fi

if [ -f "git.bash" ]; then
  source "git.bash"
fi

if [ -f "android.bash" ]; then
  source "android.bash"
fi

if [ -f "navigation.bash" ]; then
  source "navigation.bash"
fi

if [ -f "specific.bash" ]; then
  source "specific.bash"
fi
