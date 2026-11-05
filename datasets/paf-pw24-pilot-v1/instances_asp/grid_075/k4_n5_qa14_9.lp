% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=0.75
% probarg formalism=PAF
% probarg generator=PW24-original-dense-v1
% probarg generator_sha256=af3e19e91d54b12008e705fc20f912e4de71a591fecc18fa385ddc3338e8b38c
% probarg k=4
% probarg master_seed=20261105
% probarg n=5
% probarg probability_scale=10000
% probarg replicate=9
% probarg runner_sha256=2b327730befc9610a69435eabec656d566898e01e6ca810ee0826ee9fbcd6186
% probarg seed=12621555781676834184
% probarg source_commit=df7961a39dc666610298d7d2539ee2a8da315508
% probarg source_sha256=54e38b700c2409f193f3c94cb2a798fe6ccfdcf27a7e73eeedcdd7404efa5a38
arg(a0).
arg(a1).
arg(a10).
arg(a11).
arg(a12).
arg(a13).
arg(a14).
arg(a15).
arg(a16).
arg(a17).
arg(a18).
arg(a19).
arg(a2).
arg(a3).
arg(a4).
arg(a5).
arg(a6).
arg(a7).
arg(a8).
arg(a9).
p(a2,1000).
p(a16,9000).
p(a19,8000).
p(a9,9000).
p(a18,3000).
p(a0,7000).
p(a15,4000).
p(a13,2000).
p(a8,1000).
p(a14,7000).
p(a5,5000).
p(a17,5000).
p(a6,1000).
p(a11,2000).
p(a10,1000).
p(a4,8000).
p(a12,9000).
p(a1,3000).
p(a7,9000).
p(a3,9000).
att(a2,a18).
att(a18,a2).
att(a16,a19).
att(a19,a16).
att(a19,a9).
att(a9,a19).
att(a9,a13).
att(a13,a9).
att(a18,a8).
att(a8,a18).
att(a18,a0).
att(a0,a18).
att(a17,a13).
att(a8,a6).
att(a6,a8).
att(a14,a11).
att(a11,a14).
att(a5,a10).
att(a10,a5).
att(a6,a12).
att(a12,a6).
att(a11,a10).
att(a10,a11).
att(a10,a7).
att(a10,a4).
att(a4,a10).
att(a1,a12).
att(a7,a1).
att(a7,a3).
p(0,a2,a18,6000).
p(1,a18,a2,1000).
p(2,a16,a19,1000).
p(3,a19,a16,1000).
p(4,a19,a9,2000).
p(5,a9,a19,1000).
p(6,a9,a13,1000).
p(7,a13,a9,2000).
p(8,a18,a8,2000).
p(9,a8,a18,4000).
p(10,a18,a0,5000).
p(11,a0,a18,5000).
p(12,a17,a13,4000).
p(13,a8,a6,1000).
p(14,a6,a8,2000).
p(15,a14,a11,8000).
p(16,a11,a14,4000).
p(17,a5,a10,4000).
p(18,a10,a5,5000).
p(19,a6,a12,4000).
p(20,a12,a6,4000).
p(21,a11,a10,9000).
p(22,a10,a11,1000).
p(23,a10,a7,3000).
p(24,a10,a4,5000).
p(25,a4,a10,5000).
p(26,a1,a12,4000).
p(27,a7,a1,9000).
p(28,a7,a3,4000).
query(a14).