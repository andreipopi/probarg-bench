% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=0.75
% probarg formalism=PAF
% probarg generator=PW24-original-dense-v1
% probarg generator_sha256=af3e19e91d54b12008e705fc20f912e4de71a591fecc18fa385ddc3338e8b38c
% probarg k=5
% probarg master_seed=20261105
% probarg n=3
% probarg probability_scale=1
% probarg replicate=5
% probarg runner_sha256=2b327730befc9610a69435eabec656d566898e01e6ca810ee0826ee9fbcd6186
% probarg seed=7807532545148466099
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
p(a13,0.1).
p(a12,0.7).
p(a8,0.2).
p(a14,0.1).
p(a9,0.3).
p(a10,0.3).
p(a3,0.5).
p(a0,0.5).
p(a2,0.7).
p(a4,0.5).
p(a5,0.2).
p(a11,0.4).
p(a7,0.8).
p(a6,0.6).
p(a1,0.8).
att(a13,a10).
att(a12,a3).
att(a12,a8).
att(a14,a8).
att(a14,a9).
att(a9,a14).
att(a4,a9).
att(a10,a5).
att(a5,a10).
att(a10,a3).
att(a3,a11).
att(a11,a3).
att(a0,a3).
att(a7,a0).
att(a0,a2).
att(a2,a0).
att(a4,a2).
att(a7,a11).
att(a7,a6).
att(a6,a1).
att(a1,a6).
p(0,a13,a10,0.4).
p(1,a12,a3,0.4).
p(2,a12,a8,0.5).
p(3,a14,a8,0.4).
p(4,a14,a9,0.7).
p(5,a9,a14,0.2).
p(6,a4,a9,0.8).
p(7,a10,a5,0.9).
p(8,a5,a10,0.4).
p(9,a10,a3,0.5).
p(10,a3,a11,0.2).
p(11,a11,a3,0.5).
p(12,a0,a3,0.1).
p(13,a7,a0,0.2).
p(14,a0,a2,0.7).
p(15,a2,a0,0.7).
p(16,a4,a2,0.5).
p(17,a7,a11,0.5).
p(18,a7,a6,0.9).
p(19,a6,a1,0.6).
p(20,a1,a6,0.1).
query(a11).