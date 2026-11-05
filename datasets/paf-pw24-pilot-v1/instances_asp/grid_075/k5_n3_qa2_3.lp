% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=0.75
% probarg formalism=PAF
% probarg generator=PW24-original-dense-v1
% probarg generator_sha256=af3e19e91d54b12008e705fc20f912e4de71a591fecc18fa385ddc3338e8b38c
% probarg k=5
% probarg master_seed=20261105
% probarg n=3
% probarg probability_scale=10000
% probarg replicate=3
% probarg runner_sha256=2b327730befc9610a69435eabec656d566898e01e6ca810ee0826ee9fbcd6186
% probarg seed=12955954858818845819
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
p(a10,3000).
p(a4,2000).
p(a2,9000).
p(a8,1000).
p(a14,4000).
p(a13,4000).
p(a0,9000).
p(a12,8000).
p(a3,4000).
p(a9,7000).
p(a6,8000).
p(a1,1000).
p(a11,1000).
p(a5,9000).
p(a7,7000).
att(a10,a4).
att(a0,a4).
att(a2,a8).
att(a3,a8).
att(a8,a14).
att(a14,a8).
att(a9,a14).
att(a6,a13).
att(a0,a13).
att(a0,a1).
att(a1,a0).
att(a0,a12).
att(a12,a11).
att(a11,a12).
att(a12,a3).
att(a3,a12).
att(a3,a5).
att(a5,a3).
att(a9,a3).
att(a9,a7).
att(a7,a9).
att(a11,a1).
att(a11,a5).
att(a5,a11).
p(0,a10,a4,2000).
p(1,a0,a4,8000).
p(2,a2,a8,7000).
p(3,a3,a8,4000).
p(4,a8,a14,9000).
p(5,a14,a8,2000).
p(6,a9,a14,5000).
p(7,a6,a13,4000).
p(8,a0,a13,2000).
p(9,a0,a1,4000).
p(10,a1,a0,3000).
p(11,a0,a12,4000).
p(12,a12,a11,4000).
p(13,a11,a12,9000).
p(14,a12,a3,9000).
p(15,a3,a12,3000).
p(16,a3,a5,9000).
p(17,a5,a3,3000).
p(18,a9,a3,7000).
p(19,a9,a7,6000).
p(20,a7,a9,3000).
p(21,a11,a1,9000).
p(22,a11,a5,9000).
p(23,a5,a11,4000).
query(a2).