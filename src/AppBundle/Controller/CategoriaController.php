<?php

namespace AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Component\HttpFoundation\Request;
use AppBundle\Entity\Categoria;
use AppBundle\Form\CategoriaType;

class CategoriaController extends Controller
{
    /**
     * @Route("/categoria/{id}",name="categoria")
     */
    public function categoriaAction($id)
    {
        if (!is_null($id)) {
            $repository = $this->getDoctrine()->getRepository(Categoria::class);
            $categoria = $repository->find($id);
            if (empty($categoria))
                return $this->redirectToRoute('homepage');
            else
                return $this->render('default/categoria.html.twig', array("categoria" => $categoria));
        } else
            return $this->redirectToRoute('homepage');
    }

    /**
     * @Route("/nuevaCategoria/{id}",name="nueva_categoria")
     */
    public function nuevaCategoriaAction(Request $request, $id = null)
    {
        if ($id == null) {
            $categoria = new Categoria();
        } else {
            $em = $this->getDoctrine()->getManager();
            $categoria = $em->getRepository(Categoria::class)->find($id);

        }
        $form = $this->createForm(CategoriaType::class, $categoria);

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $categoria = $form->getData();

            // $file stores the uploaded PDF file
            /** @var Symfony\Component\HttpFoundation\File\UploadedFile $file */
            $fotoFile = $categoria->getFoto();
            // Generate a unique name for the file before saving it
            $fotoFileName = md5(uniqid()) . '.' . $fotoFile->guessExtension();
            // Move the file to the directory where brochures are stored
            $fotoFile->move(
                $this->getParameter('upload_foto_directorio'),
                $fotoFileName
            );
            // Update the 'brochure' property to store the PDF file name
            // instead of its contents
            $categoria->setFoto($fotoFileName);

            $em = $this->getDoctrine()->getManager();
            $em->persist($categoria);
            $em->flush();
            return $this->redirectToRoute('homepage');
        }
        return $this->render('default/nuevaCategoria.html.twig', array('form' => $form->createView()));//,'urlFoto'=>$urlFoto));
    }
}
