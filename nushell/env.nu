$env.PATH ++= [
    "~/.local/bin",
    "~/.spicetify",
    "~/.krew/bin",
    "~/.cargo/bin",
    "~/.local/share/omakub/bin",
]

$env.OMAKUB_PATH = "~/.local/share/omakub"
$env.KUBECONFIG = (glob '~/.kube/*.yml' | str join ':')

$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
