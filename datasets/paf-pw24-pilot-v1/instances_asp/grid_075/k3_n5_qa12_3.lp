% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=0.75
% probarg formalism=PAF
% probarg generator=PW24-original-dense-v1
% probarg generator_sha256=af3e19e91d54b12008e705fc20f912e4de71a591fecc18fa385ddc3338e8b38c
% probarg k=3
% probarg master_seed=20261105
% probarg n=5
% probarg probability_scale=10000
% probarg replicate=3
% probarg runner_sha256=2b327730befc9610a69435eabec656d566898e01e6ca810ee0826ee9fbcd6186
% probarg seed=12430168804153037560
% probarg source_commit=df7961a39dc666610298d7d2539ee2a8da315508
% probarg source_sha256=54e38b700c2409f193f3c94cb2a798fe6ccfdcf27a7e73eeedcdd7404efa5a38
arg(a0).
arg(a1).
arg(a10).
arg(a11).
arg(a12).
arg(a13).
arg(a14).
arg(a2).
arg(a3).
arg(a4).
arg(a5).
arg(a6).
arg(a7).
arg(a8).
arg(a9).
p(a3,6000).
p(a13,9000).
p(a7,8000).
p(a6,3000).
p(a11,7000).
p(a4,8000).
p(a9,6000).
p(a2,4000).
p(a0,8000).
p(a1,1000).
p(a8,3000).
p(a10,8000).
p(a14,7000).
p(a5,1000).
p(a12,5000).
att(a3,a6).
att(a6,a3).
att(a3,a13).
att(a13,a11).
att(a11,a13).
att(a13,a7).
att(a7,a13).
att(a4,a7).
att(a9,a6).
att(a6,a11).
att(a11,a6).
att(a4,a11).
att(a0,a4).
att(a9,a1).
att(a1,a9).
att(a2,a9).
att(a8,a2).
att(a2,a0).
att(a1,a14).
att(a14,a1).
att(a10,a12).
att(a14,a5).
att(a5,a14).
p(0,a3,a6,2000).
p(1,a6,a3,2000).
p(2,a3,a13,7000).
p(3,a13,a11,2000).
p(4,a11,a13,7000).
p(5,a13,a7,3000).
p(6,a7,a13,8000).
p(7,a4,a7,3000).
p(8,a9,a6,3000).
p(9,a6,a11,1000).
p(10,a11,a6,2000).
p(11,a4,a11,5000).
p(12,a0,a4,5000).
p(13,a9,a1,3000).
p(14,a1,a9,7000).
p(15,a2,a9,1000).
p(16,a8,a2,7000).
p(17,a2,a0,2000).
p(18,a1,a14,3000).
p(19,a14,a1,5000).
p(20,a10,a12,7000).
p(21,a14,a5,9000).
p(22,a5,a14,4000).
query(a12).