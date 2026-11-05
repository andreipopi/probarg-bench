% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=0.75
% probarg formalism=PAF
% probarg generator=PW24-original-dense-v1
% probarg generator_sha256=af3e19e91d54b12008e705fc20f912e4de71a591fecc18fa385ddc3338e8b38c
% probarg k=6
% probarg master_seed=20261105
% probarg n=3
% probarg probability_scale=1
% probarg replicate=9
% probarg runner_sha256=2b327730befc9610a69435eabec656d566898e01e6ca810ee0826ee9fbcd6186
% probarg seed=11313530043450730052
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
p(a10,0.3).
p(a17,0.8).
p(a13,0.3).
p(a16,0.1).
p(a6,0.8).
p(a5,0.5).
p(a12,0.6).
p(a11,0.6).
p(a15,0.6).
p(a0,0.8).
p(a2,0.1).
p(a3,0.2).
p(a7,0.3).
p(a8,0.2).
p(a14,0.1).
p(a4,0.6).
p(a9,0.1).
p(a1,0.8).
att(a12,a10).
att(a10,a17).
att(a17,a13).
att(a13,a17).
att(a16,a13).
att(a0,a16).
att(a5,a6).
att(a12,a7).
att(a7,a12).
att(a8,a11).
att(a15,a11).
att(a15,a14).
att(a4,a0).
att(a0,a2).
att(a2,a0).
att(a9,a2).
att(a2,a3).
att(a7,a8).
att(a8,a14).
att(a14,a8).
att(a4,a9).
att(a9,a1).
p(0,a12,a10,0.8).
p(1,a10,a17,0.4).
p(2,a17,a13,0.5).
p(3,a13,a17,0.8).
p(4,a16,a13,0.9).
p(5,a0,a16,0.8).
p(6,a5,a6,0.5).
p(7,a12,a7,0.2).
p(8,a7,a12,0.5).
p(9,a8,a11,0.4).
p(10,a15,a11,0.1).
p(11,a15,a14,0.1).
p(12,a4,a0,0.1).
p(13,a0,a2,0.5).
p(14,a2,a0,0.8).
p(15,a9,a2,0.3).
p(16,a2,a3,0.6).
p(17,a7,a8,0.4).
p(18,a8,a14,0.6).
p(19,a14,a8,0.3).
p(20,a4,a9,0.1).
p(21,a9,a1,0.1).
extension(a11).
query(a17).