<?php

namespace AppBundle\Controller;

use AppBundle\Entity\Producto;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

class DefaultController extends Controller
{
    /**
     * @Route("/", name="homepage")
     */
    public function indexAction(Request $request)
    {
        // replace this example code with whatever you need
        $reposiorio= $this->getDoctrine()->getRepository(Producto::class);
        $productos= $reposiorio->findAll();
        //var_dump($productos);
        return $this->render('default/index.html.twig', [
            'productos'=>$productos,
            'base_dir' => realpath($this->getParameter('kernel.project_dir')).DIRECTORY_SEPARATOR,
        ]);
    }

    /**
     * @Route("/nosotros", name="nosotros")
     */
    public function nosotrosAction(Request $request)
    {
        // replace this example code with whatever you need
        return $this->render('default/nosotros.html.twig', [
            'base_dir' => realpath($this->getParameter('kernel.project_dir')).DIRECTORY_SEPARATOR,
        ]);
    }

    /**
     * @Route("/contactar/{sitio}", name="contactar")
     */
    public function contactarAction(Request $request, $sitio = "todos")
    {
        // replace this example code with whatever you need
        return $this->render('default/contactar.html.twig', [
            'sitio' => $sitio,
            'base_dir' => realpath($this->getParameter('kernel.project_dir')) . DIRECTORY_SEPARATOR,
        ]);
    }

    /**
     * @Route("/producto/{id}",name="producto")
     */
    public function productoAction($id)
    {
        if (!is_null($id)) {
            $repository = $this->getDoctrine()->getRepository(Producto::class);
            $producto = $repository->find($id);
            if (empty($producto))
                return $this->redirectToRoute('homepage');
            else
            return $this->render('default/producto.html.twig', array("producto" => $producto));
        } else
            return $this->redirectToRoute('homepage');
    }
}
