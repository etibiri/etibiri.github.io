---
layout: default
title: Introduction à la Bioinformatique
description: Introduction au cours de bioinformatique - Objectifs, contenu, ressources et outils.
---

<!-- Styles personnalisés pour un design moderne et responsive -->
<style>
  /* Police moderne depuis Google Fonts */
  @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap');

  /* Reset de base et style global */
  * {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
  }
  body {
    font-family: 'Roboto', sans-serif;
    background-color: #f5f6fa;
    color: #333;
    line-height: 1.6;
  }
  /* Barre de navigation */
  .navbar {
    background-color: #2c3e50;
    padding: 1rem 0;
  }
  .navbar .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 1rem;
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-wrap: wrap;
  }
  .navbar .brand {
    font-size: 1.8rem;
    color: #ecf0f1;
    text-decoration: none;
    font-weight: bold;
  }
  .nav-links {
    list-style: none;
    display: flex;
    gap: 1.5rem;
  }
  .nav-links li a {
    color: #ecf0f1;
    text-decoration: none;
    font-size: 1rem;
    transition: color 0.3s ease;
  }
  .nav-links li a:hover {
    color: #3498db;
  }
  /* Conteneur principal */
  main {
    max-width: 960px;
    margin: 2rem auto;
    background-color: #ffffff;
    padding: 2rem;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  }
  hr {
    margin: 1.5rem 0;
    border: 0;
    border-top: 1px solid #e0e0e0;
  }
  h2 {
    color: #2c3e50;
    margin-bottom: 1rem;
    font-size: 1.6rem;
  }
  h3 {
    color: #34495e;
    margin-top: 1rem;
    font-size: 1.4rem;
  }
  p {
    margin-bottom: 1rem;
    text-align: justify;
  }
  ul, ol {
    margin-left: 1.2rem;
    margin-bottom: 1rem;
  }
  pre, code {
    background-color: #ecf0f1;
    padding: 1rem;
    border-radius: 4px;
    overflow-x: auto;
    font-family: Consolas, monospace;
  }
  a {
    color: #3498db;
    text-decoration: none;
  }
  a:hover {
    text-decoration: underline;
  }
  /* Pied de page */
  footer {
    text-align: center;
    padding: 1.5rem 0;
    font-size: 0.9rem;
    color: #555;
  }
  /* Responsive : Ajustement pour écrans de moins de 768px */
  @media (max-width: 768px) {
    .navbar .container {
      flex-direction: column;
      text-align: center;
    }
    .nav-links {
      flex-direction: column;
      gap: 0.8rem;
      margin-top: 1rem;
    }
    main {
      padding: 1rem;
      margin: 1rem;
    }
  }
</style>

<!-- Barre de navigation -->
<nav class="navbar">
  <div class="container">
    <a href="/" class="brand">📚 Bioinformatique</a>
    <ul class="nav-links">
      <li><a href="#objectifs">Objectifs</a></li>
      <li><a href="#intervenants">Intervenants</a></li>
      <li><a href="#prerequis">Prérequis</a></li>
      <li><a href="#contenu">Contenu</a></li>
      <li><a href="#ressources">Ressources</a></li>
      <li><a href="#contact">Contact</a></li>
    </ul>
  </div>
</nav>

<!-- Contenu principal -->
<main>
  <section>
    <p>
      Bienvenue dans le cours d'introduction à la bioinformatique. Ce site vous fournira toutes les informations et ressources nécessaires pour comprendre les bases et outils essentiels de la bioinformatique.
    </p>
    <p><strong>Note :</strong> La présence physique à ce cours est obligatoire.</p>
  </section>

  <hr />

  <section id="objectifs">
    <h2>🚀 Objectifs du cours</h2>
    <ul>
      <li>Comprendre les bases de la génomique et du séquençage.</li>
      <li>Explorer les outils bioinformatiques essentiels à l'analyse des données.</li>
      <li>Installer et configurer un environnement de développement pour la bioinformatique.</li>
      <li>S'initier à la programmation appliquée à la bioinformatique.</li>
    </ul>
  </section>

  <hr />

  <section id="intervenants">
    <h2>👨‍🏫 Intervenant</h2>
    <p>
      <strong>Ezechiel B. TIBIRI</strong><br />
      Chercheur à l'INERA/CNRST<br />
      Email : <a href="mailto:ezechiel.tibiri@ujkz.bf">ezechiel.tibiri@ujkz.bf</a>
    </p>
  </section>

  <hr />

  <section id="prerequis">
    <h2>🛠️ Prérequis</h2>
    <ul>
      <li>Des notions de biologie moléculaire et génomique.</li>
      <li>Une connaissance de base en informatique.</li>
      <li>Une machine avec les spécifications suivantes :
        <ul>
          <li>Processeur : 4 cœurs minimum.</li>
          <li>RAM : 8 Go ou plus.</li>
          <li>Stockage : 250 Go disponibles.</li>
        </ul>
      </li>
    </ul>
  </section>

  <hr />

  <section id="contenu">
    <h2>📋 Contenu</h2>
    <ol>
      <li><strong>Introduction à la Bioinformatique :</strong> Définition et concepts clés.</li>
      <li><strong>Installation de l'environnement de travail :</strong> Utilisation de WSL (Windows Subsystem for Linux) et d'outils comme Jupyter Notebook.</li>
      <li><strong>Programmation en bioinformatique :</strong> Introduction à Python et à l'automatisation avec Bash.</li>
      <li><strong>Études de cas :</strong> Analyse de séquences ADN et exploration de données métagénomiques.</li>
    </ol>
  </section>

  <hr />

  <section id="ressources">
    <h2>📚 Ressources</h2>
    <ul>
      <li><a href="https://www.ncbi.nlm.nih.gov" target="_blank">NCBI (National Center for Biotechnology Information)</a></li>
      <li><a href="https://www.ensembl.org" target="_blank">Ensembl Genome Browser</a></li>
      <li><a href="https://learn.microsoft.com/en-us/windows/wsl/" target="_blank">Guide WSL pour Windows</a></li>
      <li><a href="https://jupyter.org/documentation" target="_blank">Jupyter Notebook Documentation</a></li>
    </ul>
  </section>

  <hr />

  <section id="installation">
    <h2>🧑‍💻 Installation</h2>
    <ol>
      <li>Clonez ce dépôt :
        <pre><code>git clone https://github.com/etibiri/cours-bioinformatique.git</code></pre>
      </li>
      <li>Installez les dépendances nécessaires via Bash :
        <pre><code>sudo apt update && sudo apt upgrade -y
sudo apt install python3 python3-pip git
pip3 install jupyter bash_kernel</code></pre>
      </li>
      <li>Lancez Jupyter Notebook :
        <pre><code>jupyter notebook</code></pre>
      </li>
    </ol>
  </section>

  <hr />

  <section id="contact">
    <h2>📬 Contact et Feedback</h2>
    <p>
      Si vous avez des questions ou des suggestions, n'hésitez pas à nous contacter :
      <br /><strong>Email :</strong> <a href="mailto:ezechiel.tibiri@ujkz.bf">ezechiel.tibiri@ujkz.bf</a>
      <br /><strong>GitHub Issues :</strong> <a href="https://github.com/etibiri/cours-bioinformatique/issues" target="_blank">Ouvrir une issue</a>
    </p>
  </section>
</main>

<footer>
  <p>&copy; 2025 <strong>Ezechiel B. TIBIRI</strong>. Tous droits réservés. Site hébergé sur <a href="https://github.com/etibiri" target="_blank">GitHub</a>.</p>
</footer>
