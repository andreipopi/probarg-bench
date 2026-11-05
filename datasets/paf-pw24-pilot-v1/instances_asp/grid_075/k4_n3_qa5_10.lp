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
% probarg replicate=10
% probarg runner_sha256=2b327730befc9610a69435eabec656d566898e01e6ca810ee0826ee9fbcd6186
% probarg seed=8438106215080507757
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
p(a8,5000).
p(a11,6000).
p(a9,2000).
p(a7,8000).
p(a2,9000).
p(a1,3000).
p(a0,7000).
p(a6,6000).
p(a10,7000).
p(a3,9000).
p(a5,5000).
p(a4,1000).
att(a8,a11).
att(a11,a1).
att(a1,a11).
att(a11,a9).
att(a9,a0).
att(a6,a7).
att(a2,a10).
att(a2,a1).
att(a1,a2).
att(a1,a3).
att(a3,a1).
att(a1,a0).
att(a0,a1).
att(a0,a5).
att(a5,a0).
att(a6,a0).
att(a6,a4).
att(a5,a3).
att(a4,a5).
p(0,a8,a11,5000).
p(1,a11,a1,4000).
p(2,a1,a11,3000).
p(3,a11,a9,7000).
p(4,a9,a0,7000).
p(5,a6,a7,8000).
p(6,a2,a10,9000).
p(7,a2,a1,3000).
p(8,a1,a2,9000).
p(9,a1,a3,8000).
p(10,a3,a1,2000).
p(11,a1,a0,1000).
p(12,a0,a1,8000).
p(13,a0,a5,2000).
p(14,a5,a0,1000).
p(15,a6,a0,8000).
p(16,a6,a4,8000).
p(17,a5,a3,3000).
p(18,a4,a5,8000).
query(a5).