% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=0.75
% probarg formalism=PAF
% probarg generator=PW24-original-dense-v1
% probarg generator_sha256=af3e19e91d54b12008e705fc20f912e4de71a591fecc18fa385ddc3338e8b38c
% probarg k=2
% probarg master_seed=20261105
% probarg n=10
% probarg probability_scale=10000
% probarg replicate=5
% probarg runner_sha256=2b327730befc9610a69435eabec656d566898e01e6ca810ee0826ee9fbcd6186
% probarg seed=15860495717304295893
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
p(a3,2000).
p(a11,4000).
p(a5,6000).
p(a4,8000).
p(a10,4000).
p(a18,9000).
p(a17,8000).
p(a0,8000).
p(a14,4000).
p(a2,5000).
p(a12,8000).
p(a6,2000).
p(a13,6000).
p(a9,6000).
p(a1,8000).
p(a16,1000).
p(a8,4000).
p(a19,1000).
p(a15,6000).
p(a7,1000).
att(a5,a3).
att(a3,a11).
att(a11,a4).
att(a4,a11).
att(a5,a10).
att(a10,a5).
att(a4,a18).
att(a18,a4).
att(a10,a18).
att(a0,a18).
att(a17,a14).
att(a14,a17).
att(a0,a2).
att(a2,a14).
att(a12,a13).
att(a6,a12).
att(a9,a6).
att(a13,a1).
att(a1,a13).
att(a16,a9).
att(a8,a1).
att(a16,a1).
att(a15,a8).
att(a8,a19).
att(a19,a8).
att(a7,a19).
p(0,a5,a3,2000).
p(1,a3,a11,9000).
p(2,a11,a4,3000).
p(3,a4,a11,2000).
p(4,a5,a10,7000).
p(5,a10,a5,3000).
p(6,a4,a18,5000).
p(7,a18,a4,9000).
p(8,a10,a18,8000).
p(9,a0,a18,2000).
p(10,a17,a14,4000).
p(11,a14,a17,7000).
p(12,a0,a2,5000).
p(13,a2,a14,4000).
p(14,a12,a13,8000).
p(15,a6,a12,6000).
p(16,a9,a6,9000).
p(17,a13,a1,7000).
p(18,a1,a13,8000).
p(19,a16,a9,5000).
p(20,a8,a1,5000).
p(21,a16,a1,6000).
p(22,a15,a8,6000).
p(23,a8,a19,5000).
p(24,a19,a8,3000).
p(25,a7,a19,8000).
query(a15).