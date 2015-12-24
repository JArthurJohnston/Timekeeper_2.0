require_relative 'model_test_case'

class StatementOfWorkTest < ModelTestCase

  test 'sow has projects' do
    sow = StatementOfWork.create

    assert_empty sow.projects

    project1 = Project.create(statement_of_work_id: sow.id)
    project2 = Project.create(statement_of_work_id: sow.id)

    sow_projects = sow.projects
    assert_equal 2, sow_projects.length
    assert sow_projects.include?(project1)
    assert sow_projects.include?(project2)
  end

  test 'sow projects are sorted by name' do
    sow = StatementOfWork.create

    project1 = Project.create(name: 'Zeroth project is third', statement_of_work_id: sow.id)
    project2 = Project.create(name: 'Alpha project is second', statement_of_work_id: sow.id)
    project3 = Project.create(name: 'alpha (lowercase) project is last', statement_of_work_id: sow.id)
    project4 = Project.create(name: '0th project is first', statement_of_work_id: sow.id)

    assert_order_equal [project4, project1, project2, project3], sow.projects
  end

  test 'sow fields' do
    user = User.create
    sow_number = 'SOW03'
    po_number = 'SUBSOW3344'
    client_name = 'Acme Co'
    nickname = 'the name of nick'
    expected_rate = 56.34
    expected_descr = 'sflkjsflkjdf'
    sow = StatementOfWork.create(user_id: user.id,
                                 number: sow_number,
                                 purchase_order_number: po_number,
                                 client: client_name,
                                 nickname: nickname, rate: expected_rate, description: expected_descr)

    assert_equal sow_number, sow.number
    assert_equal po_number, sow.purchase_order_number
    assert_equal client_name, sow.client
    assert_equal nickname, sow.nickname
    assert_equal user, sow.user
    assert_equal expected_rate, sow.rate
    assert_equal expected_descr, sow.description
  end

  test 'sow gets rate from user when its rate is nil' do
    user = User.create rate: 20.5
    sow = StatementOfWork.create user_id: user.id

    assert_equal 20.5, sow.rate
  end

end