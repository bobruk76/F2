<template>
  <div class="container">

    <div>
      <b-navbar type="dark" variant="dark">
        <b-navbar-nav>
          <b-nav-item href="#">Home</b-nav-item>
            <b-nav-item-dropdown v-if="username" text="Опросники" right>

            <b-dropdown-item v-for="(questionnaire, index) in questionnaires" :key="index"
                v-on:click.stop="getThisQuestionnaire($event)"
                v-bind:id="questionnaire.id"
                v-b-modal.testing-modal
            >
                {{ questionnaire.title }}
            </b-dropdown-item>

            </b-nav-item-dropdown>


           <b-nav-item-dropdown  v-if="username" text="Личный кабинет">
              <b-dropdown-item
                      v-b-modal.result-modal
              >
                Результаты
            </b-dropdown-item>


           </b-nav-item-dropdown>

            <b-nav-item v-b-modal.logon-modal v-else>LogOn</b-nav-item>
            <b-nav-item right>{{ username }}</b-nav-item>

        </b-navbar-nav>
      </b-navbar>
    </div>

      <b-alert
        :variant="confirmationSetting.variant"
        dismissible
        fade
        v-model="confirmationSetting.dismissCountDown"
        @dismissed="confirmationSetting.dismissCountDown=0"
      >
        {{ confirmationSetting.message }}
      </b-alert>

      <b-modal
              ref="modal"
              id="testing-modal"
              :title="formTesting.title"
              hide-footer
        >

          <b-form
                  @submit="onSubmitTesting"
                  class="w-100"
          >

              <div v-for="(question, index) in questions" :key="index">
                <h2> {{ question.title }}</h2>
                <div >
                    <h3 v-html="question.content">
                      {{ question.content }}
                    </h3>

                  <ul class="list-group">

                    <li class="list-group-item list-group-item-action list-group-item-light">

                        <b-form-group
                                v-if="question.answers[0].checkbox"
                                v-slot="{ index }"
                        >
                            <b-form-checkbox-group
                                    :options="question.answers"
                                    v-model="checkedAnswers"
                                    value-field="id"
                                    text-field="content"
                                    plain
                                    stacked
                                    size="lg"
                                    :aria-describedby="index"
                            ></b-form-checkbox-group>
                        </b-form-group>

                        <b-form-group v-else>
                            <b-form-radio-group
                                    :options="question.answers"
                                    v-model="checkedRadioAnswers[index]"
                                    value-field="id"
                                    text-field="content"
                                    plain
                                    stacked
                                    size="lg"
                                    :aria-describedby="index"
                            ></b-form-radio-group>
                        </b-form-group>

                    </li>
                  </ul>
                </div>
              </div>
              <button type="submit" class="btn btn-success">{{ formTesting.btnSubmit }}</button>
          </b-form>

        </b-modal>

      <b-modal
              ref="modal"
              id="logon-modal"
              :title="formLogon.title"
              hide-footer
         >

             <b-form
                  @submit="onLogonSubmit"
                  @keydown.enter="onLogonSubmit"
                  class="w-100"
             >

                 <div class="form-group">
                  <label>
                    Логин:
                    <input class="form-control" type="text" v-model="username">
                  </label>
                  <br>
                  <label>
                    Пароль:
                    <input class="form-control" type="password" v-model="password">
                  </label>
              </div>

                 <button type="submit" class="btn btn-success">{{ formLogon.btnSubmit }}</button>
            </b-form>

         </b-modal>

      <b-modal
          ref="modal"
          id="result-modal"
          :title="formResult.title"
          hide-footer
          @show="getResults"
      >
            <table class="table table-dark table-stripped table-hover">
                <thead class="thead-light">
                  <tr>
                    <th>Опросник</th>
                    <th>Правильных ответов</th>
                    <th>Неправильных ответов</th>
                  </tr>
                </thead>

                <tbody>
                    <tr v-for="(result, index) in results" :key="index">
                        <td>{{ result.title }}</td>
                        <td>{{ result.count_correct_answers }} из {{ result.count_questionnaire_true_answers }}</td>
                        <td>{{ result.count_incorrect_answers }}</td>
                    </tr>
                </tbody>
            </table>

      </b-modal>

  </div>

</template>

<style lang="scss" scoped>
  @import "./styles.css";
</style>

<script src="./index.js"></script>
