module updowncounter_property(prst_,pld_cnt,pupdn_cnt,pcount_enb,pclk,
pdata_in,pdata_out);
input prst_,pld_cnt,pupdn_cnt,pcount_enb,pclk;
input [15:0] pdata_in,pdata_out;
//three properties to be checked
//the correct reset  named creset
//stable if not ld_cnt and count_enb named  nochanges
//ld_cnt off and count_enb on  up  named correctcount

`ifdef creset
always_comb 
if(!prst_) 
checkreset: assert final(pdata_out == 0)$display("Passed reset check");else $display($stime,,,"\t\t %m FAIL");
`endif
`ifdef nochanges
property pr2; 
@(posedge pclk) disable iff (!prst_) (pld_cnt&&!pcount_enb)|=> $stable(pdata_out)
endproperty
checknochanges: assert property(pr2) else $display($stime,,,"\t\t %m FAIL");
cover property(pr2) $display($stime,,,"Passed the check for stable output");
`endif
`ifdef correctcount
property pr3;
@(posedge pclk) disable iff(!prst_) (pld_cnt&&pcount_enb&&pupdn_cnt)|=> $past(pdata_out) +1 == pdata_out
endproperty 
property pr4;
@(posedge pclk) disable iff(!prst_) (pld_cnt&&pcount_enb&&!pupdn_cnt)|=> $past(pdata_out) -1 == pdata_out
endproperty
checkup:  assert property(pr3) else $display($stime,,,$past(pdata_out),,,"\t\t %m FAIL");
cover property(pr3) $display($stime,,,$past(pdata_out),,,"Passed the check for up counting");
checkdown:  assert property(pr4) else $display($stime,,,$past(pdata_out),,,"\t\t %m FAIL");
cover property(pr4) $display($stime,,,$past(pdata_out),,,"Passed the check for down counting");
`endif
endmodule