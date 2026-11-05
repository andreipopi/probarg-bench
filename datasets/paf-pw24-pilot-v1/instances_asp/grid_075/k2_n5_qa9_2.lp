% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=0.75
% probarg formalism=PAF
% probarg generator=PW24-original-dense-v1
% probarg generator_sha256=af3e19e91d54b12008e705fc20f912e4de71a591fecc18fa385ddc3338e8b38c
% probarg k=2
% probarg master_seed=20261105
% probarg n=5
% probarg probability_scale=10000
% probarg replicate=2
% probarg runner_sha256=2b327730befc9610a69435eabec656d566898e01e6ca810ee0826ee9fbcd6186
% probarg seed=16554540976596913380
% probarg source_commit=df7961a39dc666610298d7d2539ee2a8da315508
% probarg source_sha256=54e38b700c2409f193f3c94cb2a798fe6ccfdcf27a7e73eeedcdd7404efa5a38
arg(a0).
arg(a1).
arg(a2).
arg(a3).
arg(a4).
arg(a5).
arg(a6).
arg(a7).
arg(a8).
arg(a9).
p(a4,7000).
p(a9,7000).
p(a8,2000).
p(a2,5000).
p(a5,8000).
p(a7,5000).
p(a3,1000).
p(a0,8000).
p(a6,5000).
p(a1,2000).
att(a4,a8).
att(a8,a4).
att(a9,a4).
att(a9,a2).
att(a2,a9).
att(a2,a8).
att(a2,a7).
att(a5,a3).
att(a3,a5).
att(a0,a7).
att(a3,a6).
att(a3,a0).
att(a6,a1).
p(0,a4,a8,9000).
p(1,a8,a4,8000).
p(2,a9,a4,7000).
p(3,a9,a2,4000).
p(4,a2,a9,7000).
p(5,a2,a8,8000).
p(6,a2,a7,6000).
p(7,a5,a3,6000).
p(8,a3,a5,9000).
p(9,a0,a7,7000).
p(10,a3,a6,2000).
p(11,a3,a0,3000).
p(12,a6,a1,4000).
query(a9).