<template>
  <q-page class="q-pa-lg">
    <div class="dashboard-container">
      <div class="text-h5 text-weight-medium q-mb-md">Overview</div>

      <div class="row q-col-gutter-lg">
        <!-- System Health -->
        <div class="col-12 col-md-6">
          <q-card class="dashboard-card">
            <q-card-section class="row items-center justify-between">
              <div class="text-h6">System Health</div>
              <q-icon name="favorite" size="20px" />
            </q-card-section>

            <q-separator />

            <q-card-section class="text-body2 text-grey-7">
              Get an overview of your system status.
              <div class="q-mt-md row q-gutter-sm">
                <q-chip outline>CPU</q-chip>
                <q-chip outline>Disk</q-chip>
                <q-chip outline>Network</q-chip>
              </div>
            </q-card-section>
          </q-card>
        </div>

        <!-- Threat Management -->
        <div class="col-12 col-md-6">
          <q-card class="dashboard-card">
            <q-card-section class="row items-center justify-between">
              <div class="text-h6">Threat Management</div>
              <q-btn dense flat icon="filter_list" label="Filter" />
            </q-card-section>

            <q-separator />

            <q-card-section class="text-body2 text-grey-7">
              Snapshot view of the current threats.
              <div class="q-mt-md row q-gutter-sm">
                <q-chip color="negative" text-color="white">Critical</q-chip>
                <q-chip color="warning" text-color="black">Warning</q-chip>
                <q-chip outline>Action Performed</q-chip>
              </div>
            </q-card-section>
          </q-card>
        </div>

        <!-- Logs -->
        <div class="col-12 col-md-6">
          <q-card class="dashboard-card">
            <q-card-section class="row items-center justify-between">
              <div class="text-h6">Logs</div>
              <q-btn dense flat icon="filter_list" label="Filter" />
            </q-card-section>

            <q-separator />

            <q-card-section>
              <q-list bordered separator>
                <q-item v-for="i in 5" :key="i">
                  <q-item-section>
                    <q-item-label>Log entry {{ i }}</q-item-label>
                    <q-item-label caption>Details…</q-item-label>
                  </q-item-section>
                </q-item>
              </q-list>
            </q-card-section>
          </q-card>
        </div>

        <!-- Plugins -->
        <div class="col-12 col-md-6">
          <q-card class="dashboard-card">
            <q-card-section class="row items-center justify-between">
              <div class="text-h6">Plugins</div>
              <q-btn dense flat icon="filter_list" label="Filter" />
            </q-card-section>

            <q-separator />

            <q-card-section>
              <div class="text-body2 text-grey-7 q-mb-sm">Filter by:</div>
              <div class="row q-gutter-sm q-mb-md">
                <q-chip clickable outline>Active</q-chip>
                <q-chip clickable outline>Disabled</q-chip>
              </div>

              <q-expansion-item label="Plugin 1">
                <q-card>
                  <q-card-section class="text-grey-7">Plugin details…</q-card-section>
                </q-card>
              </q-expansion-item>

              <q-expansion-item label="Plugin 2" default-opened>
                <q-card>
                  <q-card-section class="text-grey-7">
                    Settings • Plugin Logs • Overview
                  </q-card-section>
                </q-card>
              </q-expansion-item>
            </q-card-section>
          </q-card>
        </div>
      </div>
    </div>
  </q-page>
</template>

<style scoped>
.dashboard-container {
  max-width: 1200px; /* puts everything in the middle of the blank space */
  margin: 0 auto;
}

.dashboard-card {
  border-radius: 14px;
}
</style>
