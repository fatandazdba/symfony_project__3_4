<?php

namespace AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Component\HttpFoundation\Request;
use AppBundle\Entity\Producto;
use AppBundle\Form\ProductoType;
use Doctrine\ORM\Tools\Pagination\Paginator;
use Doctrine\ORM\QueryBuilder;
use Doctrine\ORM\Query;

class ProductoController extends Controller
{
    /**
     * @Route("/productos/{pagina}", name="productos")
     */
    public function productosAction(Request $request, $pagina = 1)
    {
        $numeroProductos = 3;
        $reposiorio = $this->getDoctrine()->getRepository(Producto::class);
        $maxPages = intval(count($reposiorio->findAll()) / $numeroProductos);
        $productos = $reposiorio->getProductosPorPaginacion($pagina, $numeroProductos);

        return $this->render('default/productos.html.twig', [
            'productos' => $productos,
            'thisPage' => $pagina,
            'maxPages' => $maxPages,
            'base_dir' => realpath($this->getParameter('kernel.project_dir')) . DIRECTORY_SEPARATOR,
        ]);
    }

    /**
     * @Route("/nuevoProducto/{id}",name="nuevo_producto")
     */
    public function nuevoProductoAction(Request $request, $id = null)
    {
        $urlFoto = "";
        if ($id == null) {
            $producto = new Producto();
        } else {
            $em = $this->getDoctrine()->getManager();
            $producto = $em->getRepository(Producto::class)->find($id);
            //$urlFoto=$producto->getFoto();
            //$producto->setFoto(null);

        }
        $form = $this->createForm(ProductoType::class, $producto);

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $producto = $form->getData();
            //$producto->setPrecio(0.15);

            // $file stores the uploaded PDF file
            /** @var Symfony\Component\HttpFoundation\File\UploadedFile $file */
            $fotoFile = $producto->getFoto();
            // Generate a unique name for the file before saving it
            $fotoFileName = md5(uniqid()) . '.' . $fotoFile->guessExtension();
            // Move the file to the directory where brochures are stored
            $fotoFile->move(
                $this->getParameter('upload_foto_directorio'),
                $fotoFileName
            );
            // Update the 'brochure' property to store the PDF file name
            // instead of its contents
            $producto->setFoto($fotoFileName);

            $em = $this->getDoctrine()->getManager();
            $em->persist($producto);
            $em->flush();
            return $this->redirectToRoute('homepage');
        }
        return $this->render('default/nuevoProducto.html.twig', array('form' => $form->createView()));//,'urlFoto'=>$urlFoto));
    }
}
