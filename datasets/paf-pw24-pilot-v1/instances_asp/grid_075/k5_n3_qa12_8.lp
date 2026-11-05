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
% probarg replicate=8
% probarg runner_sha256=2b327730befc9610a69435eabec656d566898e01e6ca810ee0826ee9fbcd6186
% probarg seed=7133853243522965158
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
p(a5,8000).
p(a12,2000).
p(a4,4000).
p(a13,6000).
p(a11,7000).
p(a3,4000).
p(a7,6000).
p(a14,3000).
p(a8,7000).
p(a9,2000).
p(a0,1000).
p(a10,1000).
p(a2,3000).
p(a6,1000).
p(a1,2000).
att(a5,a3).
att(a3,a5).
att(a12,a5).
att(a12,a7).
att(a4,a14).
att(a4,a13).
att(a13,a8).
att(a13,a11).
att(a11,a13).
att(a11,a9).
att(a0,a3).
att(a7,a14).
att(a2,a14).
att(a14,a8).
att(a6,a8).
att(a1,a9).
att(a10,a2).
att(a6,a2).
att(a1,a6).
p(0,a5,a3,5000).
p(1,a3,a5,6000).
p(2,a12,a5,9000).
p(3,a12,a7,1000).
p(4,a4,a14,9000).
p(5,a4,a13,4000).
p(6,a13,a8,1000).
p(7,a13,a11,9000).
p(8,a11,a13,8000).
p(9,a11,a9,3000).
p(10,a0,a3,1000).
p(11,a7,a14,9000).
p(12,a2,a14,2000).
p(13,a14,a8,6000).
p(14,a6,a8,6000).
p(15,a1,a9,9000).
p(16,a10,a2,6000).
p(17,a6,a2,6000).
p(18,a1,a6,1000).
extension(a8).
query(a12).