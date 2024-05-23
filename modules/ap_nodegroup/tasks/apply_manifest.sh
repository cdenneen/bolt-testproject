#!/bin/bash

if [ "$PT_noop" = "true" ]; then
  NOOP="--noop"
fi

puppet apply --environment main \
  --execute "
    resources { 'custom_node_group':
      purge => true,
    }
    create_resources(custom_node_group, lookup('custom_node_group', { merge => deep }))
" \
$NOOP
