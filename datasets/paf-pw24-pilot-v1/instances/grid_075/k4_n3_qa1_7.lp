% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=0.75
% probarg formalism=PAF
% probarg generator=PW24-original-dense-v1
% probarg generator_sha256=af3e19e91d54b12008e705fc20f912e4de71a591fecc18fa385ddc3338e8b38c
% probarg k=4
% probarg master_seed=20261105
% probarg n=3
% probarg probability_scale=1
% probarg replicate=7
% probarg runner_sha256=2b327730befc9610a69435eabec656d566898e01e6ca810ee0826ee9fbcd6186
% probarg seed=8580350905784196363
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
p(a3,0.9).
p(a2,0.3).
p(a9,0.4).
p(a11,0.7).
p(a5,0.2).
p(a8,0.1).
p(a6,0.1).
p(a0,0.1).
p(a1,0.4).
p(a7,0.5).
p(a4,0.6).
p(a10,0.5).
att(a3,a5).
att(a2,a8).
att(a2,a9).
att(a6,a9).
att(a9,a11).
att(a11,a9).
att(a0,a11).
att(a5,a1).
att(a5,a8).
att(a7,a8).
att(a8,a6).
att(a4,a6).
att(a6,a0).
att(a0,a6).
att(a10,a0).
att(a1,a7).
att(a4,a7).
att(a10,a4).
p(0,a3,a5,0.6).
p(1,a2,a8,0.8).
p(2,a2,a9,0.9).
p(3,a6,a9,0.2).
p(4,a9,a11,0.7).
p(5,a11,a9,0.7).
p(6,a0,a11,0.5).
p(7,a5,a1,1).
p(8,a5,a8,0.2).
p(9,a7,a8,0.6).
p(10,a8,a6,0.2).
p(11,a4,a6,0.5).
p(12,a6,a0,0.5).
p(13,a0,a6,0.4).
p(14,a10,a0,0.5).
p(15,a1,a7,0.5).
p(16,a4,a7,0.5).
p(17,a10,a4,0.2).
query(a1).