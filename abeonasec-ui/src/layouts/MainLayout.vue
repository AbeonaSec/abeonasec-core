<template>
  <q-layout view="lHh Lpr lFf">
    <q-header elevated   :class="$q.dark.isActive ? 'bg-grey-10 text-white' : 'bg-grey text-white'"
>
      <q-toolbar>
        <q-btn
          flat
          dense
          round
          icon="menu"
          aria-label="Menu"
          @click="toggleLeftDrawer"
        />

        <q-toolbar-title>
          Abeona Security
        </q-toolbar-title>
        
        <!-- Dark/Light mode toggle -->
        <q-btn
          flat
          round
          dense
          :icon="$q.dark.isActive ? 'dark_mode' : 'light_mode'"
          @click="$q.dark.toggle()"
          aria-label="Toggle dark mode"
        />

        <div>v1.0.0</div>
      </q-toolbar>
    </q-header>

    <q-drawer
      v-model="leftDrawerOpen"
      show-if-above
      bordered
    >
      <q-list>
        <q-item-label
          header
        >
          Essential Links
        </q-item-label>

        <EssentialLink
          v-for="link in linksList"
          :key="link.title"
          v-bind="link"
        />
      </q-list>
    </q-drawer>

    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script setup>
import { ref } from 'vue'
import EssentialLink from 'components/EssentialLink.vue'

const linksList = [
  {
    title: 'Health',
    caption: 'System status and resource utilization',
    icon: 'favorite',
    link: '/'
  },
  {
    title: 'Threat Management',
    caption: 'Active threats and mitigation actions',
    icon: 'code',
    link: '/threats'
  },
  {
    title: 'Logs',
    caption: 'Security events and audit trails',
    icon: 'chat',
    link: '/logs'
  },
  {
    title: 'Network',
    caption: 'Traffic monitoring and connection status',
    icon: 'record_voice_over',
    link: '/network'
  },
  {
    title: 'Help',
    caption: 'Documentation and support resources',
    icon: 'rss_feed',
    link: '/help'
  }
]

const leftDrawerOpen = ref(false)

function toggleLeftDrawer () {
  leftDrawerOpen.value = !leftDrawerOpen.value
}
</script>
