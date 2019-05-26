FIFO_Master_Interface_Avalon_Bus_inst : FIFO_Master_Interface_Avalon_Bus PORT MAP (
		aclr	 => aclr_sig,
		clock	 => clock_sig,
		data	 => data_sig,
		rdreq	 => rdreq_sig,
		wrreq	 => wrreq_sig,
		almost_empty	 => almost_empty_sig,
		almost_full	 => almost_full_sig,
		empty	 => empty_sig,
		full	 => full_sig,
		q	 => q_sig,
		usedw	 => usedw_sig
	);
