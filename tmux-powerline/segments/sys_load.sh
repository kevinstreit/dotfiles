# Print out Memory, cpu and load using https://github.com/thewtex/tmux-mem-cpu-load

run_segment() {
	type sys-load >/dev/null 2>&1
	if [ "$?" -ne 0 ]; then
		return
	fi

	stats=$(sys-load 2 10)
	if [ -n "$stats" ]; then
		echo "$stats";
	fi
	return 0
}
