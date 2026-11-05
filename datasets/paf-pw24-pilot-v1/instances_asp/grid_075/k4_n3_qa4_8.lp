% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=0.75
% probarg formalism=PAF
% probarg generator=PW24-original-dense-v1
% probarg generator_sha256=af3e19e91d54b12008e705fc20f912e4de71a591fecc18fa385ddc3338e8b38c
% probarg k=4
% probarg master_seed=20261105
% probarg n=3
% probarg probability_scale=10000
% probarg replicate=8
% probarg runner_sha256=2b327730befc9610a69435eabec656d566898e01e6ca810ee0826ee9fbcd6186
% probarg seed=16629003969971298165
% probarg source_commit=df7961a39dc666610298d7d2539ee2a8da315508
% probarg source_sha256=54e38b700c2409f193f3c94cb2a798fe6ccfdcf27a7e73eeedcdd7404efa5a38
arg(a0).
arg(a1).
arg(a10).
arg(a11).
arg(a2).
arg(a3).
arg(a4).
arg(a5).
arg(a6).
arg(a7).
arg(a8).
arg(a9).
p(a2,6000).
p(a10,2000).
p(a6,2000).
p(a11,6000).
p(a8,7000).
p(a4,6000).
p(a1,3000).
p(a9,6000).
p(a3,8000).
p(a5,7000).
p(a7,8000).
p(a0,6000).
att(a8,a2).
att(a10,a2).
att(a10,a4).
att(a4,a10).
att(a6,a10).
att(a6,a1).
att(a1,a6).
att(a11,a9).
att(a9,a11).
att(a8,a3).
att(a3,a8).
att(a8,a4).
att(a4,a8).
att(a4,a5).
att(a4,a1).
att(a1,a7).
att(a0,a9).
att(a3,a5).
att(a5,a3).
att(a0,a7).
p(0,a8,a2,7000).
p(1,a10,a2,6000).
p(2,a10,a4,9000).
p(3,a4,a10,8000).
p(4,a6,a10,9000).
p(5,a6,a1,4000).
p(6,a1,a6,9000).
p(7,a11,a9,6000).
p(8,a9,a11,7000).
p(9,a8,a3,2000).
p(10,a3,a8,2000).
p(11,a8,a4,5000).
p(12,a4,a8,5000).
p(13,a4,a5,8000).
p(14,a4,a1,3000).
p(15,a1,a7,9000).
p(16,a0,a9,3000).
p(17,a3,a5,4000).
p(18,a5,a3,8000).
p(19,a0,a7,9000).
query(a4).