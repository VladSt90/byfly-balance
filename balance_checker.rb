require 'mechanize'
require 'pry'

class BalanceChecker
  LOGIN = ''
  PASSWORD = ''

  def initialize()
    @agent = Mechanize.new
  end

  def getStat()
    loginAgentToAccount(LOGIN, PASSWORD)
    balance_stat = getBalanceStat()
    megabytes_stat = getMegabytesStat
    stat = balance_stat + megabytes_stat
    printf stat
    binding.pry
  end

  private:

  def getMegabytesStat()
    statistic_page = @agent.get("https://issa.beltelecom.by/statact.html")
    megabytes_used = statistic_page.search("#node-261 table > tr:nth-child(3) > td:nth-child(4)").text
    megabytes_left = statistic_page.search("#node-261 table > tr:nth-child(3) > td:nth-child(5)").text
    last_update_datetime = statistic_page.search("#node-261 table > tr:nth-child(3) > td:nth-child(6)").text
    "Использовано: #{megabytes_used}\nОсталось: #{megabytes_left}\nПоследнее обновление: #{last_update_datetime}"
  end

  def getBalanceStat()
    "Баланс: #{getBalance}\n"
  end

  def getBalance()
    main_page = @agent.get("https://issa.beltelecom.by/main.html")
    balance = main_page.search('#node-261 > div > div > center b').text
  end

  def loginAgentToAccount(login, password)
    login_page = @agent.get("https://issa.beltelecom.by/main.html")
    form  = login_page.form_with(name: 'auth')
    form.oper_user = login
    form.passwd = password
    @agent.submit(form)
  end
end
