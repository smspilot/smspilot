//*******************************************************
������� UTF8(���)
	�����=��������(���);
	����="";
	��� �=1 �� ����� ����
		����=����(���,�,1);
		���=�������(����);
		���� ���<128 �����
			����=����+����;
		�����
			���� (���>=�������("�"))�(���<=�������("�")) �����
				����=����+����(208)+����(144+���-�������("�"));
			��������� (���>=�������("�"))�(���<=�������("�")) �����
				����=����+����(209)+����(128+���-�������("�"));
			��������� (����="�") �����
				����=����+����(209)+����(145);
			��������� (����="�") �����
				����=����+����(208)+����(129);
			���������;
		���������;
	����������;
	������� ����;
������������
//*******************************************************
��������� ������������(�������,��������)
	//������� � ������� +79���������
	// (!) �������� �� ���� API-���� https://www.smspilot.ru/my-settings.php#api
	API = "XXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZXXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZ";

	���� ��������������������������("v7plus.dll")=0 �����
		��������("�� ������� ���������� ���������� V7Plus.dll!");
	���������;

	�������
		���������� = �������������("Addin.V7HttpReader");
		����������.���������������������������� = 1;
	����������
		��������("�� ������� ������� ������ Addin.V7HttpReader!");
	������������;
	����� = "http://smspilot.ru/api.php?send=";

	���="";

	��� = UTF8(��������);

	����� = �����+������(���)+"&to="+����(������(�������),11)+"&apikey="+API;
	�������
		����������.�����������������(�����, ���);
		��������("-+-============== �������� ��� ================-+-");
		������� = "SUCCESS=SMS SENT";
		���� ���(���,16)=������� �����
			��������("��������� �� �����: "+�������);
			��������("� �������: "+��������);

			���=������(�����������(���,�������,""));
			������� = ���(���,�����(���,"/")-1);
			���=�����������(���,�������+"/","");
			�������������� = ���(���,�����(���,����(13))-1);

			��������("������� ����������! ���� �� ��� = "+�������+" ���.; ������� �� ����� = "+��������������+" ���.");
		���������;
	����������
		��������("��������� ������� �������� ���.");
	������������;
��������������