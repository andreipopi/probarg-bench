% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=0.75
% probarg formalism=PAF
% probarg generator=PW24-original-dense-v1
% probarg generator_sha256=af3e19e91d54b12008e705fc20f912e4de71a591fecc18fa385ddc3338e8b38c
% probarg k=6
% probarg master_seed=20261105
% probarg n=3
% probarg probability_scale=10000
% probarg replicate=4
% probarg runner_sha256=2b327730befc9610a69435eabec656d566898e01e6ca810ee0826ee9fbcd6186
% probarg seed=5135963323780307846
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
arg(a2).
arg(a3).
arg(a4).
arg(a5).
arg(a6).
arg(a7).
arg(a8).
arg(a9).
p(a7,6000).
p(a2,1000).
p(a14,1000).
p(a8,8000).
p(a12,7000).
p(a0,2000).
p(a4,2000).
p(a1,1000).
p(a13,4000).
p(a16,1000).
p(a3,8000).
p(a15,7000).
p(a17,3000).
p(a9,3000).
p(a11,2000).
p(a6,8000).
p(a10,4000).
p(a5,2000).
att(a7,a4).
att(a2,a7).
att(a1,a2).
att(a14,a2).
att(a13,a14).
att(a8,a12).
att(a12,a8).
att(a12,a3).
att(a3,a12).
att(a0,a12).
att(a4,a1).
att(a1,a4).
att(a1,a13).
att(a13,a16).
att(a16,a13).
att(a16,a6).
att(a16,a3).
att(a3,a16).
att(a10,a3).
att(a15,a3).
att(a17,a9).
att(a9,a17).
att(a9,a11).
att(a6,a11).
att(a6,a10).
att(a10,a6).
p(0,a7,a4,9000).
p(1,a2,a7,4000).
p(2,a1,a2,1000).
p(3,a14,a2,8000).
p(4,a13,a14,5000).
p(5,a8,a12,9000).
p(6,a12,a8,8000).
p(7,a12,a3,9000).
p(8,a3,a12,5000).
p(9,a0,a12,4000).
p(10,a4,a1,1000).
p(11,a1,a4,5000).
p(12,a1,a13,1000).
p(13,a13,a16,2000).
p(14,a16,a13,3000).
p(15,a16,a6,2000).
p(16,a16,a3,5000).
p(17,a3,a16,2000).
p(18,a10,a3,1000).
p(19,a15,a3,8000).
p(20,a17,a9,8000).
p(21,a9,a17,6000).
p(22,a9,a11,3000).
p(23,a6,a11,1000).
p(24,a6,a10,2000).
p(25,a10,a6,1000).
query(a9).