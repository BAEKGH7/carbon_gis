# GIS 프로젝트 - 탄소공간지도 시스템 구축


### 🗺 시연 영상 (링크)

<a href="https://youtu.be/8Ehh6tVZnEM">
    <img src="https://github.com/user-attachments/assets/bfd8fef2-f9ab-4c9a-9e59-4dccf473704c" width="500" />
</a>


### 🗺 개요
 ● 개발목적 : 대용량 건물에너지 데이터를 기반으로 지역별 전기/가스 사용량을 지도 페이지에 표출  
 · GIS API를 활용한 프로젝트  
 ● 개발일정 : '24.03.18 ~ '24.04.12  
 ● 특이사항 : 개인 프로젝트로 진행 

### 🗺 주요 기술

<img src="https://img.shields.io/badge/java-007396?style=for-the-badge&logo=OpenJDK&logoColor=white"> <img src="https://img.shields.io/badge/Spring-6DB33F?style=for-the-badge&logo=Spring&logoColor=white">

  <img src="https://img.shields.io/badge/html5-E34F26?style=for-the-badge&logo=html5&logoColor=white"/> <img src="https://img.shields.io/badge/css-1572B6?style=for-the-badge&logo=css3&logoColor=white"/> <img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black"/> 

<img src="https://img.shields.io/badge/openlayers-1F6B75?style=for-the-badge&logo=openlayers&logoColor=white"/> <img src="https://img.shields.io/badge/jquery-0769AD?style=for-the-badge&logo=jquery&logoColor=white"/> <img src="https://img.shields.io/badge/MyBatis-000000?style=for-the-badge&logo=MyBatis&logoColor=white"> 

<img src="https://img.shields.io/badge/qgis-589632?style=for-the-badge&logo=qgis&logoColor=white"/> <img src="https://img.shields.io/badge/postgresql-4169E1?style=for-the-badge&logo=postgresql&logoColor=white"/>
   
![Git](https://img.shields.io/badge/Git-F05032.svg?&style=for-the-badge&logo=Git&logoColor=white)
![Eclipse IDE](https://img.shields.io/badge/Eclipse%20IDE-2C2255.svg?&style=for-the-badge&logo=Eclipse%20IDE&logoColor=white)
 

### 🗺 구현 내용

 ● 지도 표출 및 레이어 발행  
 · vworld API를 활용하여 지도 표출  
 · GeoServer 레이어 발행하여 select box로 지역 선택시 해당 지역 zoom in, 색상선 표시    
  *에너지 사용량 및 범례 표출 생략

 ● 데이터 삽입  
 · 대용량 데이터(txt)를 저장하기 위한 파일 업로드 기능 구현  
 · xhr을 활용한 프로그레스바(업로드 진행률) 생성  
 · 업로드 성공/실패 여부 modal 표출
 

---

## 📍 발표자료 발췌

<a href="https://github.com/user-attachments/assets/2b8270ff-84e5-4e74-85f3-2d5372ae1eea">
    <img src="https://github.com/user-attachments/assets/2b8270ff-84e5-4e74-85f3-2d5372ae1eea" alt="image" width="700" />
</a>

<a href="https://github.com/user-attachments/assets/08017b21-36c8-4f17-b4f6-64f9ae8b48b9">
    <img src="https://github.com/user-attachments/assets/08017b21-36c8-4f17-b4f6-64f9ae8b48b9" alt="image" width="700" />
</a>

---
