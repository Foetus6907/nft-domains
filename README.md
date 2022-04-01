# Vue 3 + i18n + Typescript + Vite + ESLint + Prettier + Quasar + Jest ts + Architecture Hexagonal

This template should help get you started developing with Vue 3 and Typescript in Vite.
The template uses Vue 3 `<script setup>` SFCs, check out the [script setup docs](https://v3.vuejs.org/api/sfc-script-setup.html#sfc-script-setup) to learn more.

## Add translations to locales files

Translations are ready to go with [vue-i18](https://vue-i18n.intlify.dev/)
Add your files to `/locales` and are you are set.

## ESLint

Change your config at `.eslintrc.js`

## Prettier

Change config at `.prettierrc`

## Scripts

```js
npm i // installs packages
npm run vite // starts the dev server
npm run build // run build
npm run serve // preview build
npm run storybook // starts storybook
npm run lint // lint and fix all files
npm run format // run prettier on all files
npm run test // run all test file in tests 
```

## Type Support For `.vue` Imports in TS

Since TypeScript cannot handle type information for `.vue` imports, they are shimmed to be a generic Vue component type by default. In most cases this is fine if you don't really care about component prop types outside of templates. However, if you wish to get actual prop types in `.vue` imports (for example to get props validation when using manual `h(...)` calls), you can enable Volar's `.vue` type support plugin by running `Volar: Switch TS Plugin on/off` from VSCode command palette.

## Folder structure

```
.
├── LICENSE
├── README.md
├── index.html
├── package.json
├── test
│   ├── HomeView.spec.ts
├── public
│   ├── favicon.ico
│   ├── robots.txt
├── src
|   ├── quasar-variables.sass
|   ├── adapter
│   │   ├── primary
│   │   │  ├── App.vue
│   │   │  ├── main.ts
│   │   │  ├── components
│   │   │  │    └── HelloWorld.vue
│   │   │  │    └── LocaleSelect.vue        
│   │   │  ├── router
│   │   │  │    └── router.ts
│   │   │  ├── store
│   │   │  │    └── store.ts
│   │   │  ├── style
│   │   │  │    └── boot.scss
│   │   │  ├── assets
│   │   │  |    └── img
|   │   │  |    └── svg
|   │   │  ├── locales
|   │   │  │    ├── en.json
|   │   │  │    ├── pt.json
|   │   │  │    └── zh.json
│   │   ├── secondary
│   │   |  └── inMemory
|   |   |  |    └── InMemoryRepository
│   ├── domain
│   |   ├── useCase
|   |   |   ├── UseCase.ts
├── shims-vue.d.ts
├── tsconfig.json
├── vite.config.ts
└── jest.config.js
```
