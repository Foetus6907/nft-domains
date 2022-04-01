import HomeView from "@/adapter/primary/components/HomeView.vue";
import { createRouter, createWebHashHistory } from "vue-router";

const routes = [{ path: "/", component: HomeView }];

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});

export default router;
