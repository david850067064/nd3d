﻿package examples 
{
	import de.nulldesign.nd3d.geom.Vertex;
	import de.nulldesign.nd3d.material.Material;
	import de.nulldesign.nd3d.material.PixelMaterial;
	import de.nulldesign.nd3d.objects.Sphere;
	import de.nulldesign.nd3d.objects.Sprite3D;
	import de.nulldesign.nd3d.view.AbstractView;
	import examples.customRenderer.MyPixelRenderer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Lars Gerckens (lars@nulldesign.de)
	 */
	public class CustomPixelRendererExample extends AbstractView 
	{
		private var ticker:Number = 0;
		private var myPixelRenderer:MyPixelRenderer;
		
		public function CustomPixelRendererExample() 
		{
			super(600, 400);
			
			// steal vertices from sphere and generate sprites
			var sphere:Sphere = new Sphere(25, 200, new Material(0x000000, 1));
			var vertices:Array = sphere.vertexList;
			var s:Sprite3D;
			var v:Vertex;
			var spriteMat:PixelMaterial = new PixelMaterial(0xFF0000, 1, 5);
			spriteMat.customRenderer = myPixelRenderer = new MyPixelRenderer();
			
			for(var i:int = 1; i < vertices.length; i++)
			{
				v = vertices[i] as Vertex;
				s = new Sprite3D(spriteMat, v.x, v.y, v.z * Math.sin((i / vertices.length) * Math.PI) * 1);
				renderList.push(s);
			}
			
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		private function onMouseWheel(evt:MouseEvent):void 
		{
			cam.zOffset -= evt.delta * 10;
			myPixelRenderer.resetMeasure();
		}
		
		override protected function loop(e:Event):void
		{
			super.loop(e);

			cam.angleX += (mouseY - cam.vpY) * .0005;
			cam.angleY += (mouseX - cam.vpX) * .0005;
			
			var s:Sprite3D;
			for(var i:int = 0; i < renderList.length; i++)
			{
				s = renderList[i];
				s.positionAsVertex.z += Math.sin(ticker + (i / renderList.length) * Math.PI) * 10;
			}
			
			ticker += 0.2;
		}
	}
	
}